From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Thu, 03 Jan 2013 09:31:25 +0000
Message-ID: <50E55DFD02000078000B2A10@nat28.tlf.novell.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50E41973.9050705@citrix.com>
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
To: Andrew Cooper <andrew.cooper3@citrix.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "H. PeterAnvin" <hpa@zytor.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 02.01.13 at 12:26, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> On 27/12/12 18:02, Eric W. Biederman wrote:
>> It probably make sense to split them apart a little even.
> 
> Thinking about this split, there might be a way to simply it even more.
> 
> /sbin/kexec can load the "Xen" crash kernel itself by issuing hypercalls 
> using /dev/xen/privcmd.  This would remove the need for the dom0 kernel 
> to distinguish between loading a crash kernel for itself and loading a 
> kernel for Xen.
> 
> Or is this just a silly idea complicating the matter?

I don't think so (and suggested that before as a response to an
earlier submission of this patch set), and it would make most of
the discussion here mute.

Jan
