From: Greg KH <greg@kroah.com>
Subject: Re: [3.16 stable PATCH 1/1] virtio-rng: fix multi-device startup
Date: Tue, 12 Aug 2014 06:55:27 +0800
Message-ID: <20140811225527.GB10721__40383.3624361598$1407797836$gmane$org@kroah.com>
References: <5ef3aa4ea1932b7655d9db5a0139b8a2922af0db.1407760907.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5ef3aa4ea1932b7655d9db5a0139b8a2922af0db.1407760907.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 11, 2014 at 06:11:47PM +0530, Amit Shah wrote:
> This is a 3.16-only patch.  The linux.git fix is
> 5c06273401f2eb7b290cadbae18ee00f8f65e893, which fixes this issue in a
> different way.

Why "different"?  Why can't I take that original patch instead?  What is
different in this patch, and why?

thanks,

greg k-h
