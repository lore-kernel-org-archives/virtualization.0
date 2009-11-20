From: Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH] Replace kvm io delay pv-ops with linux magic
Date: Fri, 20 Nov 2009 09:45:16 -0800
Message-ID: <1258739116.27935.29.camel__40301.8374847763$1258739227$gmane$org@ank32.eng.vmware.com>
References: <1258548984-32433-1-git-send-email-agraf@suse.de>
	<4B05CCEB.5050802@goop.org>
	<9466A245-8DB5-40FB-AE94-168117C2C692@suse.de>
	<4B05F6BD.3050402@goop.org>
	<38BE0E5F-E8E1-42BE-B406-5DA405BDBD56@suse.de>
	<4B05FA1B.5000504@goop.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B05FA1B.5000504@goop.org>
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
Cc: Nick Piggin <npiggin@suse.de>, kvm list <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, Dan Hecht <dhecht@vmware.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2009-11-19 at 18:08 -0800, Jeremy Fitzhardinge wrote:
> On 11/20/09 09:59, Alexander Graf wrote:
> >
> > On 20.11.2009, at 02:54, Jeremy Fitzhardinge wrote:
> >
> >> On 11/20/09 07:58, Alexander Graf wrote:
> >>>
> >>> Am 19.11.2009 um 23:55 schrieb Jeremy Fitzhardinge <jeremy@goop.org>:
> >>>
> >>>> On 11/18/09 20:56, Alexander Graf wrote:
> >>>>> Currently we use pv-ops to tell linux not to do anything on io_delay.
> >>>>>
> >>>>> While the basic idea is good IMHO, I don't see why we would need
> >>>>> pv-ops
> >>>>> for that. The io delay function already has a switch that can do
> >>>>> nothing
> >>>>> if you're so inclined.
> >>>>>
> >>>>> So here's a patch (stacked on top of the previous pv-ops series) that
> >>>>> removes the io delay pv-ops hook and just sets the native io delay
> >>>>> variable instead.
> >>>>>
> >>>>
> >>>> Can you just get rid of the io_delay op altogether?  If KVM doesn't
> >>>> need
> >>>> it, then nobody does.
> >>>
> >>> Sure, can do. That'd be a separate patch though.
> >>
> >> Yep.  A patch each for VMI and Xen to remove the dependency, and a final
> >> patch to remove the op.  Hm, looks like VMI has a specific ROM call for
> >> io_delay; I wonder what it does.
> >
> > Oh so it's actually using it? Feel like doing the removal then? I
> > don't really want to mess with VMI code :-)
> 
> I would post the patch and see if Alok naks it.  But I somehow doubt
> vmware is doing anything profound with that call.
> 

Yeah removing it is fine with me. That call is just a no-op anyways,
and, if there are other ways for avoiding the IO delay cost we can use
that one too.

Alok
