From: Greg KH <greg@kroah.com>
Subject: Re: [3.16 stable PATCH v2 1/2] virtio: rng: delay hwrng_register()
	till driver is ready
Date: Fri, 3 Oct 2014 12:57:18 -0700
Message-ID: <20141003195718.GA15407@kroah.com>
References: <e85a877491a10650cd4b14de926707954a91f565.1407830026.git.amit.shah@redhat.com>
	<20140827085539.GG13052@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140827085539.GG13052@grmbl.mre>
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

On Wed, Aug 27, 2014 at 02:25:39PM +0530, Amit Shah wrote:
> Hey Greg,
> 
> Can you add these two patches to the 3.16 queue?

Now applied.
