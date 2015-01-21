From: Martin Mares <mj@ucw.cz>
Subject: Re: [pciutils patch] add virtio vendor capability support
Date: Wed, 21 Jan 2015 16:18:25 +0100
Message-ID: <mj+md-20150121.151656.2555.nikam@ucw.cz>
References: <1421839293-4197-1-git-send-email-kraxel@redhat.com>
	<mj+md-20150121.144408.23951.nikam@ucw.cz>
	<1421853400.10966.4.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421853400.10966.4.camel@nilsson.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> > (1) Please follow the coding style of the rest of pciutils.
> 
> I've tried.  What specifically doesn't match?

Positions of braces (e.g., after switch). But if you fix the other things,
I can re-indent the source myself.

				Martin
