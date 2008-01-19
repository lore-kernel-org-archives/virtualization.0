From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sun, 20 Jan 2008 10:27:48 +1100
Message-ID: <200801201027.49223.rusty__40737.8476731994$1200785414$gmane$org@rustcorp.com.au>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801191459.49735.rusty@rustcorp.com.au>
	<479177BC.8030200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479177BC.8030200@gmail.com>
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
To: Tejun Heo <htejun@gmail.com>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 19 January 2008 15:08:28 Tejun Heo wrote:
> Rusty Russell wrote:
> >     There are three possibilities: (1) force everyone to use void *, (2)
> > force everyone to be type-correct, (3) allow both with some tricks. 
> > Currently we're on (1).  For kthread, with only dozens of users, I chose
> > (2) (very simple, easy to understand).  I think for widespread things
> > like timer and interrupt handlers, I think (3) is the right way to go.
>
> Yeah, during transition, we definitely want (3).

Hi Tejun.

    I'm thinking an open-ended transition.  I don't see a big reason to churn 
working code, since we can easily support both.

> Yeah, I think we need a good flame war to determine our
> heading and converting timer shouldn't take too much of your time, right?

   Insightful comment, you've convinced me!

Thanks,
Rusty.
