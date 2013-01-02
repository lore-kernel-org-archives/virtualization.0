From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
Date: Wed, 2 Jan 2013 15:27:32 +0000
Message-ID: <1357140452.5668.69.camel__36272.5764084191$1357140485$gmane$org@zakaz.uk.xensource.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50DC58C4.3000307@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-12-27 at 14:18 +0000, Andrew Cooper wrote:
> Many cloud customers and service providers want the ability for a VM
> administrator to be able to load a kdump/kexec kernel within a
> domain[1].  This allows the VM administrator to take more proactive
> steps to isolate the cause of a crash, the state of which is most likely
> discarded while tearing down the domain.  The result being that as far
> as Xen is concerned, the domain is still alive, while the kdump
> kernel/environment can work its usual magic.  I am not aware of any
> feature like this existing in the past.

I have a feeling that some versions of the classic-Xen port supported
domU kexec as well. Certainly there was some work on that back in 2005,
although I can't see much evidence that that attempt ever went anywhere
so maybe I'm imagining things.

It's possible that I'm confusing domU kexec support with support for
domU kexec in some dom0 kernels. That was/is used to support "kexec"
from a PV bootloader into the real kernel (which looks to the host a lot
like a domU kexec would).

Ian.
