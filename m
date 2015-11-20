From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 4/9] nvmet: add a controller "start" hook
Date: Thu, 19 Nov 2015 21:31:10 -0800
Message-ID: <1447997470.3473.4.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<1447978868-17138-5-git-send-email-mlin@kernel.org>
	<20151120051355.GA19405@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151120051355.GA19405@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lin <ming.l@ssi.samsung.com>, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2015-11-20 at 06:13 +0100, Christoph Hellwig wrote:
> On Thu, Nov 19, 2015 at 04:21:03PM -0800, Ming Lin wrote:
> >  #define NVMET_SUBSYS_NAME_LEN		256
> >  	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
> > +
> > +	void			*opaque;
> > +	void			(*start)(void *);
> >  };
> 
> Why can't vhost use container_of to get at the containing structure
> similar to what the loop driver does?

struct nvme_loop_ctrl {

        struct nvme_ctrl        ctrl;

        struct nvmet_ctrl       *target_ctrl;
};

static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
{
        return container_of(ctrl, struct nvme_loop_ctrl, ctrl);
}

loop driver's container_of is used for "nvme_ctrl", not "nvmet_ctrl"

Possibly change:
struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_subsys *subsys,
                const char *subsys_name)
to 
int nvmet_init_ctrl(struct nvmet_ctrl *, ....)
?

So we can embed "struct nvmet_ctrl" to upper layer structure.

> 
> In addition I think we'll eventually need an ops structure here,
> but I can take care of that later.
