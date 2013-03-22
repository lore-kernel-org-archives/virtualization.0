From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Fri, 22 Mar 2013 15:50:37 +0100
Message-ID: <CAJK669aeEAkPrtrjM5e1pwVgvqU8CGo6TFdm5hGUEJ1PpFZLAA@mail.gmail.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
	<20130321110614.24c6ed08@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321110614.24c6ed08@gondolin>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Linus Walleij <linus.walleij@linaro.org>, Erwan YVIN <Erwan.Yvin@stericsson.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 11:06 AM, Cornelia Huck
<cornelia.huck@de.ibm.com> wrote:
> On Thu, 21 Mar 2013 18:59:26 +1030
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> Change the u32 to a u64, and make sure to use 1ULL everywhere!
>>
>> Cc: Ohad Ben-Cohen <ohad@wizery.com>
>> Cc: Brian Swetland <swetland@google.com>
>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> ---
>>  drivers/char/virtio_console.c          |    2 +-
>>  drivers/lguest/lguest_device.c         |   10 +++++-----
>>  drivers/remoteproc/remoteproc_virtio.c |    6 +++++-
>>  drivers/s390/kvm/kvm_virtio.c          |   10 +++++-----
>>  drivers/virtio/virtio.c                |   12 ++++++------
>>  drivers/virtio/virtio_mmio.c           |   14 +++++++++-----
>>  drivers/virtio/virtio_pci.c            |    5 ++---
>>  drivers/virtio/virtio_ring.c           |    2 +-
>>  include/linux/virtio.h                 |    2 +-
>>  include/linux/virtio_config.h          |    8 ++++----
>>  tools/virtio/linux/virtio.h            |    2 +-
>>  tools/virtio/linux/virtio_config.h     |    2 +-
>>  12 files changed, 41 insertions(+), 34 deletions(-)

I guess you would need to update the feature bits in remoteproc as well?
e.g. something like:

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index faf3332..148a503 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -296,8 +296,8 @@ struct fw_rsc_vdev_vring {
 struct fw_rsc_vdev {
        u32 id;
        u32 notifyid;
-       u32 dfeatures;
-       u32 gfeatures;
+       u64 dfeatures;
+       u64 gfeatures;
        u32 config_len;
        u8 status;
        u8 num_of_vrings;
@@ -470,8 +470,8 @@ struct rproc_vdev {
        struct rproc *rproc;
        struct virtio_device vdev;
        struct rproc_vring vring[RVDEV_NUM_VRINGS];
-       unsigned long dfeatures;
-       unsigned long gfeatures;
+       u64 dfeatures;
+       u64 gfeatures;
 };

Thanks,
Sjur
