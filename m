From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCHv2] tracing/events: Add bounce tracing to swiotbl
Date: Wed, 25 Sep 2013 13:56:49 -0400
Message-ID: <20130925175649.GC7253@phenom.dumpdata.com>
References: <1378325465-10384-1-git-send-email-zoltan.kiss@citrix.com>
	<5239CF01.1010001@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5239CF01.1010001@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 18, 2013 at 05:04:17PM +0100, Zoltan Kiss wrote:
> Hi,
> 
> I haven't got a reply in the past 2 weeks, so I would like to bump
> the patch, just to make sure it haven't fell off the radar.

Hey,

I have this in my queue to put on 3.13 as it is past the merge window.
.. with that in mind:


.. snip..
> >+	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
> >+		"size=%zu swiotlb_force=%x",
> >+		__get_str(dev_name),
> >+		__entry->dma_mask,
> >+		(unsigned long long)__entry->dev_addr,
> >+		__entry->size,
> >+		__entry->swiotlb_force)

Would it make sense to do something like this:

		__entry->swiotlb_force ? "swiotlb_force" : "")
