From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/4] block: move sd_format_disk_name() into block core
	as disk_name_format()
Date: Fri, 30 Mar 2012 10:56:15 +0100
Message-ID: <1333101375.2833.34.camel__18173.2551697225$1333381123$gmane$org@dabdike>
References: <4F7581D4.4040301@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F7581D4.4040301@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ren Mingxin <renmx@cn.fujitsu.com>
Cc: Jens Axboe <axboe@kernel.dk>, KVM <kvm@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, VIRTUAL <virtualization@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-03-30 at 17:50 +0800, Ren Mingxin wrote:
> 
> This patch series renames "sd_format_disk_name()" to
> "disk_name_format()" and moves it into block core. So
> that who needs formatting disk name can use it, instead
> of duplicating these similar help functions.
> 
> Ren Mingxin (4):
>    block: add function disk_name_format() into block core
>    scsi: replace sd_format_disk_name() to disk_name_format()

These two should be a single patch so it makes it obvious to anyone
looking through the change sets that the code is merely being moved.

Other than that, everything looks fine to me.

James
