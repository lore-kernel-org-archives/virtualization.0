From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Pv-drivers] RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Wed, 5 May 2010 13:31:20 -0400
Message-ID: <20100505173120.GA1752__30466.0502974459$1273080804$gmane$org@infradead.org>
References: <20100504230225.GP8323@vmware.com>
	<20100505172316.GA25338@infradead.org>
	<201005051029.42052.dtor@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005051029.42052.dtor@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: Pankaj Thakkar <pthakkar@vmware.com>, pv-drivers@vmware.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 05, 2010 at 10:29:40AM -0700, Dmitry Torokhov wrote:
> > We're not going to add any kind of loader for binry blobs into kernel
> > space, sorry.  Don't even bother wasting your time on this.
> > 
> 
> It would not be a binary blob but software properly released under GPL.
> The current plan is for the shell to enforce GPL requirement on the
> plugin code, similar to what module loaded does for regular kernel
> modules.

The mechanism described in the document is loading a binary blob
coded to an abstract API.

That's something entirely different from having normal modules for
the Virtual Functions, which we already have for various pieces of
hardware anyway.
