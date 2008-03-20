From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC/PATCH 01/15] preparation: provide hook to enable pgstes
	in	user pagetable
Date: Thu, 20 Mar 2008 12:13:25 -0700
Message-ID: <1206040405.8232.24.camel__34676.2832291008$1206044178$gmane$org@nimitz.home.sr71.net>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>
	<47E29EC6.5050403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E29EC6.5050403@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Carsten Otte <cotte@de.ibm.com>, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, hollisb@us.ibm.com, arnd@arndb.de, borntraeger@de.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-03-20 at 10:28 -0700, Jeremy Fitzhardinge wrote:
> Carsten Otte wrote:
> > +struct mm_struct *dup_mm(struct task_struct *tsk);
> 
> No prototypes in .c files.  Put this in an appropriate header.

Well, and more fundamentally: do we really want dup_mm() able to be
called from other code?

Maybe we need a bit more detailed justification why fork() itself isn't
good enough.  It looks to me like they basically need an arch-specific
argument to fork, telling the new process's page tables to take the
fancy new bit.

I'm really curious how this new stuff is going to get used.  Are you
basically replacing fork() when creating kvm guests?

-- Dave
