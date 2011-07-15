From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Large Patch Series in Email         (was Re: [PATCH 0000/0117]
 Staging: hv: Driver cleanup)
Date: Sat, 16 Jul 2011 00:07:39 +0100
Message-ID: <20110716000739.3239bac8@lxorguk.ukuu.org.uk>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<84fa825a57d34571a5aa66ae7299461c-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <84fa825a57d34571a5aa66ae7299461c-mfwitten@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

>   Do not send more than 15 patches at once to the vger
>   mailing lists!!!
> 
> and, accordingly, I went to the trouble of setting up a GitHub
> account to host a repo from which I could issue *one* single
> PULL request email; I get a little miffed every time my
> inbox gets blasted with hundreds of patches when others don't
> do similarly.

The problem with dumping stuff that needs review into a git tree is it's
a lot of hassle to review so the advice is kind of outdated in such cases.
It's good advice for things like big new subsystems perhaps but not for
review.

As is always the case social norms evolve faster than the people who feel
compelled to attempt to document them.

There are lots of web archives of the list and it's also not hard to set
up mail tools to shuffle long emails into a folder so there are plenty of
ways to manage and read the lists without being part of it.

And someone should probably updating the CodingStyle document to reflect
reality 8)

Alan
