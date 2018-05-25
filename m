From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Fri, 25 May 2018 16:28:39 -0700
Message-ID: <20180525162839.3c7028e1__282.665811437433$1527290818$gmane$org@xeon-e3>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
	<20180525153456.28b44c7c@xeon-e3>
	<c0be8e44-34f8-0e46-3a51-7ce869a5d351@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c0be8e44-34f8-0e46-3a51-7ce869a5d351@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 25 May 2018 16:11:47 -0700
"Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:

> On 5/25/2018 3:34 PM, Stephen Hemminger wrote:
> > On Thu, 24 May 2018 09:55:14 -0700
> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >  
> >> --- a/drivers/net/hyperv/Kconfig
> >> +++ b/drivers/net/hyperv/Kconfig
> >> @@ -2,5 +2,6 @@ config HYPERV_NET
> >>   	tristate "Microsoft Hyper-V virtual network driver"
> >>   	depends on HYPERV
> >>   	select UCS2_STRING
> >> +	select FAILOVER  
> > When I take a working kernel config, add the patches then do
> > make oldconfig
> >
> > It is not autoselecting FAILOVER, it prompts me for it. This means
> > if user says no then a non-working netvsc device is made.  
> 
> I see
>     Generic failover module (FAILOVER) [M/y/?] (NEW)
> 
> So the user is given an option to either build as a Module or part of the
> kernel. 'n' is not an option.

With most libraries there is no prompt at all.
