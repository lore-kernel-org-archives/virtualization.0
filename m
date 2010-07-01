From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH] virt-what.in: Added VMware virt detection using cpuid
	in wrapper script
Date: Thu, 1 Jul 2010 14:15:47 +0100
Message-ID: <20100701131547.GI6805__45207.8097187497$1277990197$gmane$org@amd.home.annexia.org>
References: <AANLkTim1m-HIRMHVIkJLSZitXCh1ZwKh2eAN3UxUxJ1E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim1m-HIRMHVIkJLSZitXCh1ZwKh2eAN3UxUxJ1E@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chetan Loke <chetanloke@gmail.com>
Cc: Tzy-Jye Daniel Lin <ephemient@gmail.com>, kvm@vger.kernel.org, rjones@trick.home.annexia.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 29, 2010 at 07:29:01PM -0400, Chetan Loke wrote:
> Brief discussion thread - http://lkml.org/lkml/2010/6/29/355
> 
> Added VMware detection via cpuid.Mimic'd VMware's balloon driver's init-time
> check(cpuid followed by dmi-checks). Moved the existing logic into a simple
> function to achieve that.
> 
> Tested virt-what.in(ran as a script) and virt-what-cpuid-helper within
> a Linux guest on ESX. Thanks.

Chetan, do you think you could send me this one again as an
attachment.  Some MUA/MTA along the way has sufficiently mangled the
patch such that it can no longer be applied.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://et.redhat.com/~rjones/virt-top
