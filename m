From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 27 Jul 2009 15:37:13 -0500
Message-ID: <4A6E0FF9.6010308__11984.2351800346$1248727093$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090727203214.GG15020@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Daniel P. Berrange wrote:
> I don't think that's not too bad, for example, with fast-user-switching
> between multiple X servers and/or text consoles, there's already support
> code that deals with chown'ing things like /dev/snd/* devices to match 
> the active console session. Doing the same with the /dev/vmch3 device so
> that it is only ever accessible to the current logged in user actually
> fits in to that scheme quite well.
>   

Yeah, I'm not sure how something like this would interact with f-u-s.

If copy/paste daemon for user foo opens /dev/vmch3 directly, when you 
switch users, how do you forcefully disconnect user foo from /dev/vmch3 
so that user bad can start using it?

Regards,

Anthony Liguori

> Daniel
>   
