From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: INDIRECT and NEXT
Date: Fri, 23 Oct 2009 19:50:31 +1030
Message-ID: <200910231950.31241.rusty@rustcorp.com.au>
References: <20091004143734.GB17578@redhat.com>
	<200910231401.24419.rusty@rustcorp.com.au>
	<20091023063648.GC10821@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091023063648.GC10821@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 23 Oct 2009 05:06:48 pm Michael S. Tsirkin wrote:
> On Fri, Oct 23, 2009 at 02:01:23PM +1030, Rusty Russell wrote:
> > Also, we have a limitation that you can't have more descriptors than the ring
> > size, even with indirect, due to overzealous checks...
> 
> Yes ... so I wonder: do we want to fix all this and add a feature bit,
> or wait until some guest actually wants to use such descriptors?

Yes, we wait until someone wants it.  Then (1) we have a test case, and
(2) we can make sure we don't do those (bogus, frankly) >= ringsize checks.

Thanks,
Rusty.
