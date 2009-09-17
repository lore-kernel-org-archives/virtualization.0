From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 17 Sep 2009 14:15:31 +0100
Message-ID: <20090917141531.4d2489d4__32804.5131908313$1253193444$gmane$org@lxorguk.ukuu.org.uk>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090911163806.GB25535@amit-x200.redhat.com>
	<4AAA8838.1080106@codemonkey.ws>
	<20090911173307.GB27046@amit-x200.redhat.com>
	<4AAA8A56.3040707@codemonkey.ws>
	<20090916112332.6bf981a5@linux.intel.com>
	<4AB164A0.8000402@codemonkey.ws> <87tyz1en5f.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87tyz1en5f.fsf@pike.pond.sub.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

> Well, really fundamentally, this is just a reliable full-duplex byte
> stream, with connect and hangup notification.  To me, that sounds more
> like TCP with an address family almost, but not quite AF_UNIX, but that
> case was thrown out of court long ago, so here we are.

Well the tty one has also been thrown out of court because its even dumber

To be honest it sounds more to me like either a pipe or a char device, or
in most cases like sysfs.

Alan
