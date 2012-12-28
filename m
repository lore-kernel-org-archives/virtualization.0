From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
	page table PGD, PUD, PMD and PTE
Date: Fri, 28 Dec 2012 13:59:27 +0100
Message-ID: <20121228125926.GA13224__5040.20456360212$1357236009$gmane$org@x1.alien8.de>
References: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <71b94237-c365-47ba-8d75-5ee1d8caee73@default>
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
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, maxim.uvarov@oracle.com, kexec@lists.infradead.org, x86@kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 27, 2012 at 03:19:24PM -0800, Daniel Kiper wrote:
> > Hmm... this code is being redone at the moment... this might conflict.
> 
> Is this available somewhere? May I have a look at it?

http://marc.info/?l=linux-kernel&m=135581534620383

The for-x86-boot-v7 and -v8 branches.

HTH.

-- 
Regards/Gruss,
Boris.
