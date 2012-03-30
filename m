From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONT - Type 2]"
	<asamymuthupa@micron.com>
Subject: Re: [PATCH 3/4] block: replace rssd_disk_name_format() to
	disk_name_format()
Date: Fri, 30 Mar 2012 23:54:12 +0000
Message-ID: <4F764778.1030406__43483.6995126263$1333381139$gmane$org@micron.com>
References: <4F7581D4.4040301@cn.fujitsu.com> <4F758297.5020600@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F758297.5020600@cn.fujitsu.com>
Content-Language: en-US
Content-ID: <1E778E757F563B4A8AC9502D61A5B220@exchange>
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

On 3/30/2012 2:53 AM, Ren Mingxin wrote:

>  Currently, block core has been supplied "disk_name_format()", so
> we should remove duplicate function "rssd_disk_name_format()"
> and use the new function to format rssd disk names.
> 
> Signed-off-by: Ren Mingxin <renmx@cn.fujitsu.com>
> ---
>  mtip32xx.c |   33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)


Looks fine.

Should the subject be "mtip32xx: ..." instead of "block: ..."? I
understand "block:" as relating to block core. I am fairly new here. If
"block:" can be used for block drivers too, that is fine too.

--
Regards,
Asai Thambi
