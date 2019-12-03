From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH RFC v7 net-next] netdev: pass the stuck queue to the
 timeout handler
Date: Tue, 3 Dec 2019 10:07:01 -0800
Message-ID: <20191203100701.0d6a367e__34900.9951388993$1575396446$gmane$org@cakuba.netronome.com>
References: <20191203071101.427592-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191203071101.427592-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dnmendes76@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jcfaracco@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 3 Dec 2019 02:12:48 -0500, Michael S. Tsirkin wrote:
> This allows incrementing the correct timeout statistic without any mess.
> Down the road, devices can learn to reset just the specific queue.
> 
> The patch was generated with the following script:

Still:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
