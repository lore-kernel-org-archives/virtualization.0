From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 00/11]  virtio: s4 support
Date: Thu, 15 Dec 2011 15:13:14 +0200
Message-ID: <20111215131314.GA22791@redhat.com>
References: <cover.1323952933.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1323952933.git.amit.shah@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 15, 2011 at 06:15:46PM +0530, Amit Shah wrote:
> Hi,
> 
> These patches add support for S4 to virtio (pci) and all drivers.
> 
> Michael saw some race in virtio-net module removal which will need a
> similar fix for the freeze code as well.  I'll update the virtio-net
> patch with that fix once the fix is settled upon and applied.

block too?

-- 
MST
