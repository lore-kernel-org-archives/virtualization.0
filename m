From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
	pr_warn
Date: Thu, 23 Feb 2017 09:18:24 -0800
Message-ID: <1487870304.14159.29.camel__26793.231527745$1487879055$gmane$org@perches.com>
References: <cover.1487314666.git.joe@perches.com>
	<CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, nouveau@lists.freedesktop.org, Linux-ALSA <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>, sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, xen-devel@lists.xenproject.org, linux-media@vger.k
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2017-02-23 at 09:28 -0600, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> > There are ~4300 uses of pr_warn and ~250 uses of the older
> > pr_warning in the kernel source tree.
> > 
> > Make the use of pr_warn consistent across all kernel files.
> > 
> > This excludes all files in tools/ as there is a separate
> > define pr_warning for that directory tree and pr_warn is
> > not used in tools/.
> > 
> > Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
[]
> Where's the removal of pr_warning so we don't have more sneak in?

After all of these actually get applied,
and maybe a cycle or two later, one would
get sent.
