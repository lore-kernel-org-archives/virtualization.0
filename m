From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2] tracing/events: Add bounce tracing to swiotbl
Date: Wed, 25 Sep 2013 14:26:40 -0400
Message-ID: <20130925142640.6c2f1ee0__44413.4872676388$1380134041$gmane$org@gandalf.local.home>
References: <1378325465-10384-1-git-send-email-zoltan.kiss@citrix.com>
	<5239CF01.1010001@citrix.com>
	<20130925175649.GC7253@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130925175649.GC7253@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Zoltan Kiss <zoltan.kiss@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Sep 2013 13:56:49 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> .. snip..
> > >+	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
> > >+		"size=%zu swiotlb_force=%x",
> > >+		__get_str(dev_name),
> > >+		__entry->dma_mask,
> > >+		(unsigned long long)__entry->dev_addr,
> > >+		__entry->size,
> > >+		__entry->swiotlb_force)
> 
> Would it make sense to do something like this:
> 
> 		__entry->swiotlb_force ? "swiotlb_force" : "")

I think that's fine. I do believe that the libtraceevents can parse the
"?:" syntax.

-- Steve
