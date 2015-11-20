From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 4/9] nvmet: add a controller "start" hook
Date: Fri, 20 Nov 2015 06:13:55 +0100
Message-ID: <20151120051355.GA19405__46833.6948114031$1447996795$gmane$org@lst.de>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<1447978868-17138-5-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1447978868-17138-5-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: Ming Lin <ming.l@ssi.samsung.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 19, 2015 at 04:21:03PM -0800, Ming Lin wrote:
>  #define NVMET_SUBSYS_NAME_LEN		256
>  	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
> +
> +	void			*opaque;
> +	void			(*start)(void *);
>  };

Why can't vhost use container_of to get at the containing structure
similar to what the loop driver does?

In addition I think we'll eventually need an ops structure here,
but I can take care of that later.
