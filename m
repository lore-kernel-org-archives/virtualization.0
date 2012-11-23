From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Fri, 23 Nov 2012 12:13:08 +0100
Message-ID: <20121123111308.GB3002@host-192-168-1-59.local.net-space.pl>
References: <87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
	<50AEBF86.50501@citrix.com>
	<18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
	<50AED7B8.7040902@citrix.com>
	<50AF55B102000078000AABF3@nat28.tlf.novell.com>
	<20121123103726.GB2921@host-192-168-1-59.local.net-space.pl>
	<1353667868.13542.218.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1353667868.13542.218.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 23, 2012 at 10:51:08AM +0000, Ian Campbell wrote:
> On Fri, 2012-11-23 at 10:37 +0000, Daniel Kiper wrote:
> > On Fri, Nov 23, 2012 at 09:53:37AM +0000, Jan Beulich wrote:
> > > >>> On 23.11.12 at 02:56, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > > > The crash region (as specified by crashkernel= on the Xen command line)
> > > > is isolated from dom0.
> > > >[...]
> > >
> > > But all of this _could_ be done completely independent of the
> > > Dom0 kernel's kexec infrastructure (i.e. fully from user space,
> > > invoking the necessary hypercalls through the privcmd driver).
> >
> > No, this is impossible. kexec/kdump image lives in dom0 kernel memory
> > until execution.
>
> Are you sure? I could have sworn they lived in the hypervisor owned
> memory set aside by the crashkernel= parameter as Andy suggested.

I am sure. It is moved to final resting place when
relocate_kernel() is called by hypervisor.

Daniel
