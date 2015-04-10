From: Rusty Russell <rusty@ozlabs.org>
Subject: Re: [PATCH] virtio_config: reorder functions
Date: Fri, 10 Apr 2015 12:51:33 +0930
Message-ID: <87vbh4zn0i.fsf@rustcorp.com.au>
References: <1427814977-11504-1-git-send-email-mst@redhat.com>
	<20150408164933-mutt-send-email-mst@redhat.com>
	<20150409144630.3c9145b1.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150409144630.3c9145b1.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Wed, 8 Apr 2015 16:49:46 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Tue, Mar 31, 2015 at 05:17:25PM +0200, Michael S. Tsirkin wrote:
>> > This simply reorders functions in virtio_config
>> > so width access wrapper helpers are all together.
>> > Drops an extra empty line while we are at it.
>> > 
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> 
>> Ping
>> 
>> > ---
>> >  include/linux/virtio_config.h | 15 +++++++--------
>> >  1 file changed, 7 insertions(+), 8 deletions(-)
>> > 
>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Sorry, it's in my virtio-next tree, I obviously failed to Ack.

Applied,
Rusty.
