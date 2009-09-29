From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 22:41:45 +0930
Message-ID: <200909292241.46275.rusty__34492.6771861084$1254230046$gmane$org@rustcorp.com.au>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252678386-17404-2-git-send-email-amit.shah@redhat.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 11 Sep 2009 11:43:06 pm Amit Shah wrote:
> Expose multiple char devices ("ports") for simple communication
> between the host userspace and guest.

OK, I think other comments have died down, so it's time for a review.  This
was the latest patch I could find.

The obvious way to do this is to use multiple pairs of virtqueues.  Is this
silly for some reason?  Yes, we're restricted to 32k ports.

It means that if we see the MULTIQUEUE feature, we can look for the other
queues.  Our current MSI-X friendly API makes that a little painful, but
if we resolve that our code should be sweetness, no?

Rusty.
