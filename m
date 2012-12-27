From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 06/11] x86/xen: Add i386 kexec/kdump implementation
Date: Thu, 27 Dec 2012 15:23:02 -0800 (PST)
Message-ID: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: hpa@zytor.com
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> > Add i386 kexec/kdump implementation.
> >
> > v2 - suggestions/fixes:
> >     - allocate transition page table pages below 4 GiB
> >       (suggested by Jan Beulich).
>
> Why?

Sadly all addresses are passed via unsigned long
variable to kexec hypercall.

Daniel
