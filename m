From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [3.16 stable PATCH 1/1] virtio-rng: fix multi-device startup
Date: Tue, 12 Aug 2014 11:01:58 +0530
Message-ID: <20140812053158.GJ4184@grmbl.mre>
References: <5ef3aa4ea1932b7655d9db5a0139b8a2922af0db.1407760907.git.amit.shah@redhat.com>
	<20140811225527.GB10721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140811225527.GB10721@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 12 Aug 2014 [06:55:27], Greg KH wrote:
> On Mon, Aug 11, 2014 at 06:11:47PM +0530, Amit Shah wrote:
> > This is a 3.16-only patch.  The linux.git fix is
> > 5c06273401f2eb7b290cadbae18ee00f8f65e893, which fixes this issue in a
> > different way.
> 
> Why "different"?  Why can't I take that original patch instead?  What is
> different in this patch, and why?

The commit referenced moves the hwrng_register() call to the ->scan()
callback instead of it being in probe().  This was done to ensure the
virtio-rng devices can contribute to the initial system entropy
introduced in commit d9e7972619334.

That patch is quite small too, but will need a slight conflict
resolution due to the previous two code-shuffling patches, and also
the following revert.

However, I decided against the backport of the ->scan() method, since
it wasn't designed to solve this regression, it happens to solve it,
and it actually introduces new functionality.  I would be happy to
provide a backport of the relevant patches, if you think that would be
alright.

Thanks,

		Amit
