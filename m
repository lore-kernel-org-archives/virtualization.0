From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: [PATCH 6/7] bio-cgroup: Implement the bio-cgroup
Date: Fri, 08 Aug 2008 16:10:05 +0900
Message-ID: <489BF14D.6050009__22008.3193075427$1218179528$gmane$org@oss.ntt.co.jp>
References: <20080804.175707.104036289.ryov@valinux.co.jp>	<20080804.175748.189722512.ryov@valinux.co.jp>	<20080804.175934.112619046.ryov@valinux.co.jp>
	<20080804.180022.183027902.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080804.180022.183027902.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

Ryo Tsuruta wrote:
> +static void bio_cgroup_move_task(struct cgroup_subsys *ss,
> +				struct cgroup *cont,
> +				struct cgroup *old_cont,
> +				struct task_struct *p)
> +{
> +	struct mm_struct *mm;
> +	struct bio_cgroup *biog, *old_biog;
> +
> +	if (bio_cgroup_disabled())
> +		return;
> +
> +	mm = get_task_mm(p);
> +	if (mm == NULL)
> +		return;
> +
> +	biog = cgroup_bio(cont);
> +	old_biog = cgroup_bio(old_cont);
> +
> +	mmput(mm);
> +	return;
> +}

Is this function fully implemented?
I tried to put a process into a group by writing to 
"/cgroup/bio/BGROUP/tasks" but failed.

I think this function is not enough to be used as "attach."

> +
> +
> +struct cgroup_subsys bio_cgroup_subsys = {
> +	.name           = "bio",
> +	.subsys_id      = bio_cgroup_subsys_id,
> +	.create         = bio_cgroup_create,
> +	.destroy        = bio_cgroup_destroy,
> +	.pre_destroy	= bio_cgroup_pre_destroy,
> +	.populate       = bio_cgroup_populate,
> +	.attach		= bio_cgroup_move_task,
> +	.early_init	= 0,
> +};

Without "attach" function, it is difficult to check
the effectiveness of block I/O tracking.

Thanks,
- Takuya Yoshikawa
