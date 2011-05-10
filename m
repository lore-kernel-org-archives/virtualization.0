From: Christoph Hellwig <hch@infradead.org>
Subject: Re: various vmbus review comments
Date: Tue, 10 May 2011 01:24:25 -0400
Message-ID: <20110510052425.GA31087@infradead.org>
References: <20110503204641.GA11132@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20110504163228.GA19754@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20110509143352.GB29635@infradead.org>
	<6E21E5352C11B742B20C142EB499E0481E95C6@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481E95C6@TK5EX14MBXC128.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 09, 2011 at 02:56:52PM +0000, KY Srinivasan wrote:
> I will address this. Greg had a concern about module reference counting
> and looking at the current code, it did not appear to be an issue. The
> change you are suggesting will not affect the vmbus core which is what I want
> to focus on. I will however, fix this issue in the current round of patches I will
> send out this week.

It very clearly affects the interface between the core and the
functional drivers.  Trying to submit the core without making sure the
interface is exports works properly is not an overly good idea.
