From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] S390: take a full byte as ext_param indicator
Date: Tue, 24 Aug 2010 15:24:16 +0200
Message-ID: <4C73C800.4020000__21931.2844485559$1282657372$gmane$org@de.ibm.com>
References: <1282599077-29857-1-git-send-email-agraf@suse.de>
	<4C736EAF.9020107@de.ibm.com> <4C73B5C1.5040603@suse.de>
	<4C73B78C.2030003@de.ibm.com> <4C73B97E.2060303@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030805050604000504000201"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C73B97E.2060303@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030805050604000504000201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Am 24.08.2010 14:22, schrieb Avi Kivity:
> First of all we need a virtio/s390 specification, like we have a
> virtio/pci spec.

Here is something that I started a year ago but never finished.

Christian





--------------030805050604000504000201
Content-Type: text/plain;
 name="virtio.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="virtio.txt"

guest/host interface for s390/virtio devices

            KVM_DEVICE_DESCRIPTOR PAGE
                0        8        16       24    31
              +--------+--------+--------+--------+
            0 | type   | num_vq | featlen| conflen|
              +--------+--------+--------+--------+
            1 | status |                          |
              +--------+                          +------>+
            2 |                 config            |       |
              +                                   +       |
                            ...                           |
                                                          |
    +-----------------------------------------------------+
    |
    |       CONFIG ARRAY
    |           0        8        16       24    31
    +-------->+--------+--------+--------+--------+
            0 |                                   |
              +                                   +
            1 |                                   |
              +                                   +
            2 |                                   |
              +    virtqueue 0                    +------>+
            3 |                                   |       |
              +                                   +       |
            4 |                                   |       |
              +                                   +       |
            5 |                                   |       |
              +--------+--------+--------+--------+       |
              |///////////////////////////////////+       |
              |///////////////////////////////////+       |
              +--------+--------+--------+--------+       |
              |                                   |       |
              +                                   +       |
              |                                   |       |
              +                                   +       |
              |                                   |       |
              +    virtqueue num_vq - 1           +------>+
              |                                   |       |
              +                                   +       |
              |                                   |       |
              +                                   +       |
              |                                   |       |
              +--------+--------+--------+--------+       |
     num_vq*6 | feature bits  (featlen * 2 Bytes) |       |
              +                 +--------+--------+       |
              |                 |                 |       |
              +--------+--------+                 +       |
              | config space (conflen Bytes)      |       |
              +                          +--------+       |
              |                          |                |
              +--------+--------+--------+                |
                                                          |
                                                          |
    +-----------------------------------------------------+
    |
    |       VIRTQUEUE
    |          0        8        16       24    31
    |-------->+--------+--------+--------+--------+
            0 |     interrupt token ...           |
              +                                   +
            1 |     ... set by guest              |
              +--------+--------+--------+--------+
            2 |     virtio ring address           |
              +                                   +
            3 |     ... set by host               |
              +--------+--------+--------+--------+
            4 | number of elems |/////////////////+
              +--------+--------+/////////////////+
            5 |///////////////////////////////////+
              +--------+--------+--------+--------+



            COMPLETE KVM_DEVICE_DESCRIPTOR PAGE
                0        8        16       24    31
              +--------+--------+--------+--------+
            0 | type   | num_vq | featlen| conflen|
              +--------+--------+--------+--------+
            1 | status |  interrupt token         |
              +--------+                          +
            2 | virtqueue 0(set by guest)         |
              +        +--------+--------+--------+
            3 |        | virtio ring address      |
              +--------+                          +
            4 | virtqueue 0 (set by host)         |
              +        +--------+--------+--------+
            5 |        | number of descr |////////|
              +--------+--------+--------+////////+
            6 |///////////////////////////////////|
              +////////+--------+--------+--------+
            7 |////////|   interrupt token        |
              +--------+                          +
            8 | virtqueue 1(set by guest)         |
              +        +--------+--------+--------+
            9 |        | virtio ring address      |
              +--------+                          +
           10 | virtqueue 1 (set by host)         |
              +        +--------+--------+--------+
           11 |        | number of descr |////////|
              +--------+--------+--------+////////+
           12 |///////////////////////////////////|
              +////////+--------+--------+--------+
           13 |////////|
              +--------+      .....

            ? |///////////////////////////////////|
              +////////+--------+--------+--------+
            ? |////////| feature bits             |
              +--------+ (size multiple  +--------+
              |          of 2 bytes)     |        |
              +--------+--------+--------+        +
              | config space (size of any length) |
              +                 +++++++++++++++++++
              |                 |
              +--------+--------+




Host->Guest notification:
-------------------------

via external interrupt with
- real storage 0x86-0x87 : 0x2603  --> host interrupt
- real storage 0x84: 0xd --> VIRTIO_SUBCODE_64
- real storage 0x11B8-0x11bf: the interrupt token (is a pointer to a struct virtqueue -> set by guest)
- real storage 0x83:
   0: normal interrupt
   1: config change

Guest->Host notification:
-------------------------
via  diagnose call:

diag 2,4,0x500\n"

 The calling convention is similar to the
 * s390 ABI, so we use R2-R6 for parameters 1-5. In addition we use R1
 * as hypercall number and R7 as parameter 6. The return value is
 * written to R2. We use the diagnose instru

hypercall numbers are
#define KVM_S390_VIRTIO_NOTIFY          0
#define KVM_S390_VIRTIO_RESET           1
#define KVM_S390_VIRTIO_SET_STATUS      2



Virtio Ring: (3Pages)
---------------------

                0        8        16       24    31
              +--------+--------+--------+--------+\
            0 |  Desriptor 0:                     | \
              +  guest physical address           +  \
            1 |                                   |   \
              +--------+--------+--------+--------+     one descriptor
            2 | Descriptor 0: Length              |   /
              +--------+--------+--------+--------+  /
            3 |   D0: Flags     |   D0: Next      | /
              +--------+--------+--------+--------+/
              |                                   |
                              ...
              |                                   |
              +--------+--------+--------+--------+
            0 |       Descriptor num -1           |
              +  - guest physical address 64bit   +
            1 |  - Length 32bit                   |
              +  - flags 16 bit                   +
            2 |  - next 16 bit                    |
              +                                   +
            3 |                                   |
              +--------+--------+--------+--------+
              |///////////////////////////////////|
                                ...
              |///////////////////////////////////|
              +--------+--------+--------+--------+
         4096 |   avail_flags   |    avail_idx    |
              +--------+--------+--------+--------+
         4097 |  available 0    |   available 1   |
              +--------+--------+--------+--------+
              |                                   |
                               ...
              |                                   |
              +--------+--------+--------+--------+
              | available num-2 | available num-1 |
              +--------+--------+--------+--------+
              |///////////////////////////////////|
                                ...
              |///////////////////////////////////|
              +--------+--------+--------+--------+
         8192 |   used_flags    | used_idx        |
              +--------+--------+--------+--------+
              | used_elem_id 0                    |
              +--------+--------+--------+--------+
              | used_elem_len 0                   |
              +--------+--------+--------+--------+
              |                                   |
                               ...
              |                                   |
              +--------+--------+--------+--------+
              | used_elem_id num-1                |
              +--------+--------+--------+--------+
              | used_elem_len num-1               |
              +--------+--------+--------+--------+



--------------030805050604000504000201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------030805050604000504000201--
