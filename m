From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 06/25] xen: Core Xen implementation
Date: Wed, 25 Apr 2007 21:43:48 +0200
Message-ID: <200704252143.48363.ak@suse.de>
References: <20070423215638.563901986@goop.org>
	<200704251112.45898.ak@suse.de> <462FAEE3.9090900@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462FAEE3.9090900@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 25 April 2007 21:41:23 Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> ... will review the rest later.
> >>     
> >
> > Rest is ok
> >   
> 
> Thanks for looking at it.  I'll try to separate xen-core into more
> digestable pieces.

For me you don't need anymore, but possibly for others.

To summarize the outstanding issues are:
- fixing sched_clock first
- hopefully more review of the core pieces by others
- what i commented (minor stuff mostly)
- review of xenbus and drivers
[i did upto the grant table code, but not more] 


-Andi
