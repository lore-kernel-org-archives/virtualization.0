From: James.Smart@Emulex.Com
Subject: RE: RFC: I/O bandwidth controller
Date: Tue, 12 Aug 2008 11:03:24 -0400
Message-ID: <D1D4C3FF75F9354393DB8314DF43DEF2E7F7ED__25739.6087902181$1218554300$gmane$org@xbl3.emulex.com>
References: <1218117578.11703.81.camel@sebastian.kern.oss.ntt.co.jp><48A0A689.40908@gmail.com>	<loom.20080812T071504-212@post.gmane.org><20080812.201025.57762305.taka@valinux.co.jp><48A18854.9020000@gmail.com>
	<48A18B1F.6080000@gmail.com>
	<1218549276.4456.100.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: fernando@oss.ntt.co.jp, righi.andrea@gmail.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, dm-devel@redhat.com, agk@sourceware.org, baramsori72@gmail.com, dave@linux.vnet.ibm.com, ngupta@google.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Fernando Luis V=E1zquez Cao wrote:
> > BTW as I said in a previous email, an interesting path to =

> be explored
> > IMHO could be to think in terms of IO time. So, look at the =

> time an IO
> > request is issued to the drive, look at the time the =

> request is served,
> > evaluate the difference and charge the consumed IO time to the
> > appropriate cgroup. Then dispatch IO requests in function of the
> > consumed IO time debts / credits, using for example a token-bucket
> > strategy. And probably the best place to implement the IO time
> > accounting is the elevator.
> Please note that the seek time for a specific IO request is strongly
> correlated with the IO requests that preceded it, which means that the
> owner of that request is not the only one to blame if it =

> takes too long
> to process it. In other words, with the algorithm you propose =

> we may end
> up charging the wrong guy.

I assume all of these discussions are focused on simple storage - disks
direct attached to a single server - and are not targeted at SANs with
arrays, multi-initiator accesses, and fabric/network impacts. True ? =

Such algorithms can be seriously off-base in these latter configurations.

-- james s
