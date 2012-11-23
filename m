From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Fri, 23 Nov 2012 09:56:52 +0000
Message-ID: <50AF567402000078000AABF6@nat28.tlf.novell.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com> <50AE62E9.3000602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50AE62E9.3000602@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

>>> On 22.11.12 at 18:37, "H. Peter Anvin" <hpa@zytor.com> wrote:
> I actually talked to Ian Jackson at LCE, and mentioned among other 
> things the bogosity of requiring a PUD page for three-level paging in 
> Linux -- a bogosity which has spread from Xen into native.  It's a page 
> wasted for no good reason, since it only contains 32 bytes worth of 
> data, *inherently*.  Furthermore, contrary to popular belief, it is 
> *not* pa page table per se.
> 
> Ian told me: "I didn't know we did that, and we shouldn't have to." 
> Here we have suffered this overhead for at least six years, ...

Even the Xen kernel only needs the full page when running on a
64-bit hypervisor (now that we don't have a 32-bit hypervisor
anymore, that of course basically means always). But yes, I too
never liked this enforced over-allocation for native kernels (and
was surprised that it was allowed in at all).

Jan
