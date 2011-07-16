From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 020/117] Staging: hv: vmbus: Support the notion of id
 tables in vmbus_match()
Date: Sat, 16 Jul 2011 14:24:54 -0400
Message-ID: <20110716182454.GA19023@infradead.org>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-20-git-send-email-kys@microsoft.com>
 <20110716020250.GA7199@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480817A4C9@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480817A4C9@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 16, 2011 at 12:54:46PM +0000, KY Srinivasan wrote:
> > would be nice to add uuid_{le,be}_is_nil helpers to uuid.h.  I also
> > think simply using a memcpy might be more efficient than the hand-rolled
> > loop.
> Having a helper function would be great. With regards to the efficiency of this loop,
> this is not a performance critical path. If people feel strongly about this, I could 
> change this; perhaps as a separate patch on top of this series; I don't want to send a large
> patch-set like this again.

I'm fine with doing it later.
