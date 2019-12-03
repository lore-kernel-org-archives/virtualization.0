From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [net-next V3 1/2] netdev: pass the stuck queue to the timeout
 handler
Date: Tue, 3 Dec 2019 01:46:08 -0500
Message-ID: <20191203014532-mutt-send-email-mst__36079.7700284579$1575355591$gmane$org@kernel.org>
References: <20191126200628.22251-1-jcfaracco@gmail.com>
 <20191126200628.22251-2-jcfaracco@gmail.com>
 <c2cddeea-8a6e-f0b9-1fde-7d2a29538518@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c2cddeea-8a6e-f0b9-1fde-7d2a29538518@solarflare.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Martin Habets <mhabets@solarflare.com>
Cc: dnmendes76@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Julio Faracco <jcfaracco@gmail.com>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 27, 2019 at 03:11:51PM +0000, Martin Habets wrote:
> Your @work correctly identifies that the drivers/net/ethernet/sfc drivers need patching, but the actual patches for them are missing.
> Please add those. Makes me wonder if any other files are missing patches.
> 
> Martin

Good point, pattern was missing _ in variable name. Will repost a
fixed version.
