From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [PATCH 4/7] blkio-cgroup: The body of blkio-cgroup
Date: Tue, 05 May 2009 07:43:58 +0900 (JST)
Message-ID: <20090505.074358.226774631.ryov__26576.56213637$1241477345$gmane$org@valinux.co.jp>
References: <20090428.214535.71090234.ryov@valinux.co.jp>
	<20090428.214604.104034341.ryov@valinux.co.jp>
	<20090504120544.GA3986@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090504120544.GA3986@linux>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: righi.andrea@gmail.com
Cc: containers@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Andrea,

From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH 4/7] blkio-cgroup: The body of blkio-cgroup
Date: Mon, 4 May 2009 14:05:45 +0200

> On Tue, Apr 28, 2009 at 09:46:04PM +0900, Ryo Tsuruta wrote:
> > The body of bio-cgroup.
> > 
> > Based on 2.6.30-rc3-git3
> > Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
> > Signed-off-by: Ryo Tsuruta <ryov@valinux.co.jp>
> 
> Hi Ryo,
> 
> few minor coding style issues reported by checkpatch.pl:

Thanks for reporting these issues. I'll fix them in the next release.

> 
> WARNING: line over 80 characters
> #138: FILE: include/linux/biotrack.h:67:
> +static inline void blkio_cgroup_set_owner(struct page *page, struct mm_struct *mm)
> 
> WARNING: line over 80 characters
> #152: FILE: include/linux/biotrack.h:81:
> +static inline void blkio_cgroup_copy_owner(struct page *page, struct page *opage)
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #513: FILE: mm/biotrack.c:265:
> +EXPORT_SYMBOL(get_blkio_cgroup_id);
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #514: FILE: mm/biotrack.c:266:
> +EXPORT_SYMBOL(blkio_cgroup_lookup);
> 
> total: 0 errors, 4 warnings, 515 lines checked
> 
> -Andrea

Thanks,
Ryo Tsuruta
