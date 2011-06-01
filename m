From: Mark Wu <dwu@redhat.com>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Wed, 01 Jun 2011 04:25:48 -0400
Message-ID: <4DE5F78C.1010102__31062.0081065737$1307027519$gmane$org@redhat.com>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1306913069-23637-1-git-send-email-dwu@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Wu <dwu@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/01/2011 03:24 AM, Mark Wu wrote:
> -	if (index_to_minor(index)>= 1<<  MINORBITS)
> -		return -ENOSPC;
> +	do {
> +		if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
> +			return err;
> +
There's a problem in above code: err is not initialized before using, so 
change it to return -1;
+       do {
+               if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
+                       return -1;
