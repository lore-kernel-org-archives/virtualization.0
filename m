From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/12] VMCI for Linux upstreaming
Date: Mon, 26 Nov 2012 14:37:54 -0800
Message-ID: <20121126223754.GA28681@kroah.com>
References: <20121121202625.13252.86346.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121121202625.13252.86346.stgit@promb-2n-dhcp175.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 21, 2012 at 12:31:04PM -0800, George Zhang wrote:
> 
> * * *
> This series of VMCI linux upstreaming patches include latest udpate from
> VMware.
> 
> Summary of changes:
> 
> 	- Sparse clean.
> 	- Checkpatch clean with one exception, a "complex macro" in
> 	  which we can't add parentheses.
> 	- Remove all runtime assertions.
> 	- Fix device name, so that existing user clients work.
> 	- Fix VMCI handle lookup.

Given that you failed to answer the questions I asked the last time you
posted this series, and you did not make any of the changes I asked for,
I can't accept this (nor should you expect me to.)

And people wonder why reviewers get so grumpy...

My trees are now closed for the 3.8 merge window, so feel free to try
again after 3.8-rc1 is out, and you have answered, and addressed, the
questions and comments I made.

greg k-h
