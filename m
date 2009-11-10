From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Tue, 10 Nov 2009 12:49:14 +1030
Message-ID: <200911101249.14390.rusty__48391.9243015864$1257819617$gmane$org@rustcorp.com.au>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<200911061740.03734.rusty@rustcorp.com.au>
	<20091109120839.GA11256@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091109120839.GA11256@amit-x200.redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 9 Nov 2009 10:38:39 pm Amit Shah wrote:
> > 3) Don't use list_for_each_safe() to get the head entry of a list.  Your
> >    use is buggy anyway: buf will never be NULL afterwards.
> 
> As long as 'head' isn't the only node in the list we should loop. And
> list_foreach_safe() does that. So it's OK right?

If there's more than one, buf will be == head.

> I'm sorry for having created more work for you; I'll send out my patches
> to you in a couple of days.

I spent some time on the weekend creating patches.  They're not finished,
but they start the process of maturing the driver to where it can handle
multiple ports.

The next step is real buffer management (ie. the infrastructure for more than
one in flight, even though the normal console won't do this), then adding
headers.

I will post them now so you can take a look...
Rusty.
