From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/35] treewide trivial patches converting pr_warning to
	pr_warn
Date: Fri, 17 Feb 2017 13:27:00 +0100
Message-ID: <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A__38551.1045264595$1487967484$gmane$org@mail.gmail.com>
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
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, nouveau@lists.freedesktop.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org, drbd-dev@lists.linbit.com, "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>, Richard Weinberger <richard@nod.at>, sfi-devel@simplefirmware.org, amd-gfx@lists.freedesktop.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, tboot-devel@lists.sourceforge.net, oprofile-list@lists.sf.net, linux-input@vger.kernel.org, xen-devel@lists.xenproject.or
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 17, 2017 at 8:11 AM, Joe Perches <joe@perches.com> wrote:
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

Sorry about asking if that has been asked already.

Wouldn't it be slightly less intrusive to simply redefined
pr_warning() as a synonym for pr_warn()?

Thanks,
Rafael
