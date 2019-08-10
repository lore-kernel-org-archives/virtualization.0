From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vhost: do not reference a file that does not exist
Date: Sat, 10 Aug 2019 01:15:40 -0700
Message-ID: <20190810081540.GA30426__35346.0389933147$1565424953$gmane$org@infradead.org>
References: <20190808005255.106299-1-egranata@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190808005255.106299-1-egranata@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: egranata@chromium.org
Cc: trivial@kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, egranata@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 07, 2019 at 05:52:55PM -0700, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@google.com>
> 
> lguest was removed from the mainline kernel in late 2017.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

But this particular file even has an override in the script looking
for dead references, which together with the content of the overal
contents makes me thing the dangling reference is somewhat intentional.
