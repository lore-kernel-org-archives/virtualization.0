From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH 09/14] xen: events: Remove redundant check
	on unsigned variable
Date: Mon, 19 Nov 2012 10:31:15 +0000
Message-ID: <1353321075.18229.29.camel__37307.858587201$1353321712$gmane$org@zakaz.uk.xensource.com>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
	<1353048646-10935-10-git-send-email-tushar.behera@linaro.org>
	<20121116160923.GP22320@phenom.dumpdata.com>
	<b0cd27cf-919f-46b0-afa1-4566f6ea0f61@email.android.com>
	<50A9AD05.5080201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50A9AD05.5080201@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-11-19 at 03:52 +0000, Tushar Behera wrote:
> On 11/16/2012 10:23 PM, Jeremy Fitzhardinge wrote:
> > To be honest I'd nack this kind of patch. The test is only redundant in the most trivial sense that the compiler can easily optimise away. The point of the test is to make sure that the range is OK even if the type subsequently becomes signed (to hold a -ve error, for example).
> > 
> > J
> > 
> 
> The check is on the function argument which is unsigned, so checking '<
> 0' doesn't make sense. We should force signed check only if the argument
> is of signed type. In any case, even if irq has been assigned some error
> value, that would be caught by the check irq >= nr_irqs.

Jeremy is (I think) arguing that this check is not redundant because
someone might change the type of the argument to be signed and until
then the compiler can trivially optimise the check away, so what's the
harm in it?

I'm somewhat inclined to agree with him.

Ian.
