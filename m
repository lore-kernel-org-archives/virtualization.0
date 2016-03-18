From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] gpu/drm: Use u64_to_user_pointer
Date: Fri, 18 Mar 2016 10:43:31 -0700
Message-ID: <1458323011.26915.6.camel__18404.5364534997$1458325189$gmane$org@perches.com>
References: <201603190148.px58QxiJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201603190148.px58QxiJ%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <lkp@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo@padovan.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-tegra@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2016-03-19 at 01:39 +0800, kbuild test robot wrote:
> Hi Joe,
> 
> [auto build test WARNING on drm/drm-next]
> [also build test WARNING on next-20160318]
> [cannot apply to v4.5]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improving the system]

Thanks, but this depends on Gustavo's patches too.
