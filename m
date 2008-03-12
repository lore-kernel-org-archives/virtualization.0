From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Date: Thu, 13 Mar 2008 09:41:47 +1100
Message-ID: <200803130941.48480.rusty@rustcorp.com.au>
References: <20080312132132.520833247@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755524AbYCLWmo@vger.kernel.org>
In-Reply-To: <20080312132132.520833247@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 13 March 2008 00:21:32 Martin Schwidefsky wrote:
> My question now is how to proceed with the code. I sure
> would love to see the code going upstream some day but that depends on
> the mm developers as the code adds complexity that needs to be supported.

Well, I want this feature, but I agree about complexity.

AFAICT, the trivial subset of this is the hinting of Unused pages.  It seems 
that would buy us something, and perhaps be a stepping stone to full page 
hinting?

Cheers,
Rusty.
