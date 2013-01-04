From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Fri, 04 Jan 2013 14:41:17 +0000
Message-ID: <50E6F81D02000078000B3245@nat28.tlf.novell.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
	<20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "H. Peter Anvin" <hpa@zytor.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 04.01.13 at 15:22, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> On Wed, Jan 02, 2013 at 11:26:43AM +0000, Andrew Cooper wrote:
>> /sbin/kexec can load the "Xen" crash kernel itself by issuing
>> hypercalls using /dev/xen/privcmd.  This would remove the need for
>> the dom0 kernel to distinguish between loading a crash kernel for
>> itself and loading a kernel for Xen.
>>
>> Or is this just a silly idea complicating the matter?
> 
> This is impossible with current Xen kexec/kdump interface.

Why?

> It should be changed to do that. However, I suppose that
> Xen community would not be interested in such changes.

And again - why?

Jan
