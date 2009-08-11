From: "Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu>
Subject: RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Tue, 11 Aug 2009 07:55:04 -0700
Message-ID: <001001ca1a93$b6e50ee0$24af2ca0$__23110.8810673051$1250002857$gmane$org@edu>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<200908081149.27409.arnd@arndb.de>
	<0199E0D51A61344794750DC57738F58E6D6AE99743@GVW1118EXC.americas.hpqcorp.net>
	<200908101707.32751.arnd@arndb.de>
	<0199E0D51A61344794750DC57738F58E6D6AE99C53@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E6D6AE99C53@GVW1118EXC.americas.hpqcorp.net>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "'Fischer, Anna'" <anna.fischer@hp.com>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, adobriyan@gmail.com, evb@yahoogroups.com, 'Stephen Hemminger' <shemminger@linux-foundation.org>, davem@davemloft.net, 'Eric Biederman' <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

> >
> > The patch from Eric Biederman to allow macvlan to bridge between
> > its slave ports is at
> >
> > http://kerneltrap.org/mailarchive/linux-netdev/2009/3/9/5125774
> 
> Looking through the discussions here, it does not seem as if a decision
> was made to integrate those patches, because they would make the
> macvlan
> interface behave too much like a bridge. Also, it seems as if there was
> still a problem with doing multicast/broadcast delivery when enabling
> local VM-to-VM communication. Is that solved by now?
> 

Also, is there a solution, or plans for a solution, to address macvtap
interfaces that are set to 'promiscuous' mode?  It would seem fairly easy to
support this for interfaces that are simply trying to listen to the port
(e.g. Wireshark).  If the port was being used by something like a firewall
then the VEPA filtering doesn't work too well.

Paul
