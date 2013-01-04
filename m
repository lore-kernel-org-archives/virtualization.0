From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
	page table PGD, PUD, PMD and PTE
Date: Fri, 4 Jan 2013 15:12:32 +0100
Message-ID: <20130104141232.GB3346__46806.5932546326$1357308818$gmane$org@host-192-168-1-59.local.net-space.pl>
References: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
	<20121228125926.GA13224@x1.alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121228125926.GA13224@x1.alien8.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>, hpa@zytor.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, tglx@linutronix.de, ebiederm@xmission.com, maxim.uvarov@oracle.com, andrew.cooper3@citrix.com, jbeulich@suse.com, mingo@redhat.com, x86@kernel.org, virtualization@lists.linux-foundation.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 28, 2012 at 01:59:27PM +0100, Borislav Petkov wrote:
> On Thu, Dec 27, 2012 at 03:19:24PM -0800, Daniel Kiper wrote:
> > > Hmm... this code is being redone at the moment... this might conflict.
> >
> > Is this available somewhere? May I have a look at it?
>
> http://marc.info/?l=linux-kernel&m=135581534620383
>
> The for-x86-boot-v7 and -v8 branches.
>
> HTH.

Thanks.

Daniel
