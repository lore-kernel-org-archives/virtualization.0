From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 1/1] VSOCK: Introduce VM Sockets
Date: Fri, 25 Jan 2013 16:15:19 -0800
Message-ID: <2312112.Fz0qTjDOJB__1012.84677298299$1359159351$gmane$org@dtor-d630.eng.vmware.com>
References: <1359135470-30677-1-git-send-email-acking@vmware.com>
	<1359135470-30677-2-git-send-email-acking@vmware.com>
	<20130125235953.GA4833@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130125235953.GA4833@hmsreliant.think-freely.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: pv-drivers@vmware.com
Cc: acking@vmware.com, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, gregkh@linuxfoundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Neil,

On Friday, January 25, 2013 06:59:53 PM Neil Horman wrote:
> On Fri, Jan 25, 2013 at 09:37:50AM -0800, acking@vmware.com wrote:
> > +
> > +config VMWARE_VSOCK
> > +	tristate "Virtual Socket protocol"
> > +	depends on VMWARE_VMCI
> 
> What is CONFIG_VMWARE_VMCI?  I don't find that in any Kconfig in the tree?
> 
> I''m still looking over the rest, but I get build issues if I just remove
> the dependency.

VMCI is in linux-next at the moment.

Thanks,
Dmitry
