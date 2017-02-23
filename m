From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
	pr_warn
Date: Thu, 23 Feb 2017 09:28:23 -0600
Message-ID: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ__2673.69917496598$1487863740$gmane$org@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, nouveau@lists.freedesktop.org, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>, sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, xen-devel@lists.xenproject.org, linux-media@vger.k
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> There are ~4300 uses of pr_warn and ~250 uses of the older
> pr_warning in the kernel source tree.
>
> Make the use of pr_warn consistent across all kernel files.
>
> This excludes all files in tools/ as there is a separate
> define pr_warning for that directory tree and pr_warn is
> not used in tools/.
>
> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Miscellanea:
>
> o Coalesce formats and realign arguments
>
> Some files not compiled - no cross-compilers
>
> Joe Perches (35):
>   alpha: Convert remaining uses of pr_warning to pr_warn
>   ARM: ep93xx: Convert remaining uses of pr_warning to pr_warn
>   arm64: Convert remaining uses of pr_warning to pr_warn
>   arch/blackfin: Convert remaining uses of pr_warning to pr_warn
>   ia64: Convert remaining use of pr_warning to pr_warn
>   powerpc: Convert remaining uses of pr_warning to pr_warn
>   sh: Convert remaining uses of pr_warning to pr_warn
>   sparc: Convert remaining use of pr_warning to pr_warn
>   x86: Convert remaining uses of pr_warning to pr_warn
>   drivers/acpi: Convert remaining uses of pr_warning to pr_warn
>   block/drbd: Convert remaining uses of pr_warning to pr_warn
>   gdrom: Convert remaining uses of pr_warning to pr_warn
>   drivers/char: Convert remaining use of pr_warning to pr_warn
>   clocksource: Convert remaining use of pr_warning to pr_warn
>   drivers/crypto: Convert remaining uses of pr_warning to pr_warn
>   fmc: Convert remaining use of pr_warning to pr_warn
>   drivers/gpu: Convert remaining uses of pr_warning to pr_warn
>   drivers/ide: Convert remaining uses of pr_warning to pr_warn
>   drivers/input: Convert remaining uses of pr_warning to pr_warn
>   drivers/isdn: Convert remaining uses of pr_warning to pr_warn
>   drivers/macintosh: Convert remaining uses of pr_warning to pr_warn
>   drivers/media: Convert remaining use of pr_warning to pr_warn
>   drivers/mfd: Convert remaining uses of pr_warning to pr_warn
>   drivers/mtd: Convert remaining uses of pr_warning to pr_warn
>   drivers/of: Convert remaining uses of pr_warning to pr_warn
>   drivers/oprofile: Convert remaining uses of pr_warning to pr_warn
>   drivers/platform: Convert remaining uses of pr_warning to pr_warn
>   drivers/rapidio: Convert remaining use of pr_warning to pr_warn
>   drivers/scsi: Convert remaining use of pr_warning to pr_warn
>   drivers/sh: Convert remaining use of pr_warning to pr_warn
>   drivers/tty: Convert remaining uses of pr_warning to pr_warn
>   drivers/video: Convert remaining uses of pr_warning to pr_warn
>   kernel/trace: Convert remaining uses of pr_warning to pr_warn
>   lib: Convert remaining uses of pr_warning to pr_warn
>   sound/soc: Convert remaining uses of pr_warning to pr_warn

Where's the removal of pr_warning so we don't have more sneak in?

Rob
