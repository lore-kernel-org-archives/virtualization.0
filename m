From: Ren Mingxin <renmx@cn.fujitsu.com>
Subject: Re: [PATCH 0/4] block: move sd_format_disk_name() into block core
	as disk_name_format()
Date: Fri, 30 Mar 2012 18:10:57 +0800
Message-ID: <4F7586B1.9040709__33352.1352069967$1333381132$gmane$org@cn.fujitsu.com>
References: <4F7581D4.4040301@cn.fujitsu.com>
	<1333101375.2833.34.camel@dabdike>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1333101375.2833.34.camel@dabdike>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <axboe@kernel.dk>, KVM <kvm@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, VIRTUAL <virtualization@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi, James:

On 03/30/2012 05:56 PM, James Bottomley wrote:
> On Fri, 2012-03-30 at 17:50 +0800, Ren Mingxin wrote:
>> This patch series renames "sd_format_disk_name()" to
>> "disk_name_format()" and moves it into block core. So
>> that who needs formatting disk name can use it, instead
>> of duplicating these similar help functions.
>>
>> Ren Mingxin (4):
>>     block: add function disk_name_format() into block core
>>     scsi: replace sd_format_disk_name() to disk_name_format()
> These two should be a single patch so it makes it obvious to anyone
> looking through the change sets that the code is merely being moved.

Thank you very much for so quick checking. I'll merge these
two patches into one in the next version.

> Other than that, everything looks fine to me.
>
>

Thanks,
Ren
