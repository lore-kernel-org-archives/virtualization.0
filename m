From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Date: Mon, 5 Nov 2018 15:02:30 +0100
Message-ID: <f7a5924f-b401-7b49-4734-9a21afc8cb3b__2904.99612824551$1541428994$gmane$org@de.ibm.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<20181102142446-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181102142446-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/02/2018 07:26 PM, Michael S. Tsirkin wrote:
> On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
>> vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
>> driver allows VM to reach a near bare-metal disk performance. See IOPS
>> numbers below (fio --rw=randread --bs=4k).
>>
>> This implementation uses kiocb interface. It is slightly slower than
>> going directly through bio, but is simpler and also works with disk
>> images placed on a file system.


This should also work with other transports like virtio-ccw (instead of virtio-pci).
Correct?

>>
>> # fio num-jobs
>> # A: bare metal over block
>> # B: bare metal over file
>> # C: virtio-blk over block
>> # D: virtio-blk over file
>> # E: vhost-blk bio over block
>> # F: vhost-blk kiocb over block
>> # G: vhost-blk kiocb over file
>> #
>> #  A     B     C    D    E     F     G
>>
>> 1  171k  151k  148k 151k 195k  187k  175k
>> 2  328k  302k  249k 241k 349k  334k  296k
>> 3  479k  437k  179k 174k 501k  464k  404k
>> 4  622k  568k  143k 183k 620k  580k  492k
>> 5  755k  697k  136k 128k 737k  693k  579k
>> 6  887k  808k  131k 120k 830k  782k  640k
>> 7  1004k 926k  126k 131k 926k  863k  693k
>> 8  1099k 1015k 117k 115k 1001k 931k  712k
>> 9  1194k 1119k 115k 111k 1055k 991k  711k
>> 10 1278k 1207k 109k 114k 1130k 1046k 695k
>> 11 1345k 1280k 110k 108k 1119k 1091k 663k
>> 12 1411k 1356k 104k 106k 1201k 1142k 629k
>> 13 1466k 1423k 106k 106k 1260k 1170k 607k
>> 14 1517k 1486k 103k 106k 1296k 1179k 589k
>> 15 1552k 1543k 102k 102k 1322k 1191k 571k
>> 16 1480k 1506k 101k 102k 1346k 1202k 566k
>>
>> Vitaly Mayatskikh (1):
>>   Add vhost_blk driver
> 
> 
> Thanks!
> Before merging this, I'd like to get some acks from userspace that it's
> actually going to be used - e.g. QEMU block maintainers.
> 
>>  drivers/vhost/Kconfig  |  13 ++
>>  drivers/vhost/Makefile |   3 +
>>  drivers/vhost/blk.c    | 510 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 526 insertions(+)
>>  create mode 100644 drivers/vhost/blk.c
>>
>> -- 
>> 2.17.1
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
