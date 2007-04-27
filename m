From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH 06/25] xen: Core Xen implementation
Date: Fri, 27 Apr 2007 08:31:23 +0100
Message-ID: <C257655B.66F1%Keir.Fraser@cl.cam.ac.uk>
References: <4631A157.9040702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4631A157.9040702@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>
Cc: Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

On 27/4/07 08:08, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

>> Don't you need a rmb() here then? The CPU could speculate reads
>> (more occurrences)
>>   
> 
> Is rmb() sufficient?  It will stop a speculative read on the pending
> flag, but will it make sure the write has happened by then?  Ie, is it a
> write-vs-read barrier, or just a read-vs-read?
> Documentation/memory-barriers.txt suggests not.

The barrier() is sufficient. We are racing against Xen checking
evtchn_upcall_mask *on the local cpu*. Which means an interrupt has to
occur, which squashes speculative stuff.

Yeah, I know, it needs a better comment. :-)

 -- Keir
