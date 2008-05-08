From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] stop_machine: make stop_machine_run more
	virtualization friendly
Date: Thu, 8 May 2008 16:41:20 +0200
Message-ID: <200805081641.20572.borntraeger__2977.05952912128$1210258153$gmane$org@de.ibm.com>
References: <200805081520.38310.borntraeger@de.ibm.com>
	<48230137.9090705@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48230137.9090705@goop.org>
Content-Disposition: inline
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
Cc: kvm-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 8. Mai 2008 schrieb Jeremy Fitzhardinge:
> Christian Borntraeger wrote:
> > On kvm I have seen some rare hangs in stop_machine when I used more guest
> > cpus than hosts cpus. e.g. 32 guest cpus on 1 host cpu triggered the
> > hang quite often. I could also reproduce the problem on a 4 way z/VM host 
with 
> > a 64 way guest.
> >   
> 
> I think that's one of those "don't do that then" cases ;)

I really like 64 guest cpus as a good testcase for all kind of things. 

> 
> I think x86 (at least) is now using ticket locks, which is fair.  Which 
> kernel are you seeing this problem on?

Sorry, forgot to mention. Its kvm.git from 2 days ago on s390.
