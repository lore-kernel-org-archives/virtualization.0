From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Thu, 14 Mar 2013 19:39:18 +0200
Message-ID: <20130314173918.GB29411@redhat.com>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5141E990.7070609@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 14, 2013 at 04:15:28PM +0100, Paolo Bonzini wrote:
> Il 14/03/2013 12:10, Michael S. Tsirkin ha scritto:
> > Add field for guest to specify command size for virtio-blk.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

OK, but Rusty usually tweaks wording anyway.
Rusty want to apply and make changes Paolo suggested yourself
or want me to?

> > ---
> >  virtio-spec.lyx | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 78 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> > index a8ce3f9..fea97ed 100644
> > --- a/virtio-spec.lyx
> > +++ b/virtio-spec.lyx
> > @@ -5826,6 +5826,16 @@ VIRTIO_BLK_F_TOPOLOGY (10) Device exports information on optimal I/O alignment.
> >  \change_inserted 1531152142 1341302349
> >  VIRTIO_BLK_F_CONFIG_WCE (11) Device can toggle its cache between writeback
> >   and writethrough modes.
> > +\change_inserted 1986246365 1363257418
> > +
> > +\end_layout
> > +
> > +\begin_layout Description
> > +
> > +\change_inserted 1986246365 1363258629
> > +VIRTIO_BLK_F_CMD_SIZE (12) cmd_size field is valid.
> 
> SCSI_CMD_SIZE and scsi_cmd_size please.
> 
> > +\change_inserted 1531152142 1341302349
> > +
> >  \end_layout
> >  
> >  \end_deeper
> > @@ -5994,6 +6004,30 @@ struct virtio_blk_config {
> >  \change_inserted 1531152142 1341301918
> >  
> >      u8 writeback;
> > +\change_inserted 1986246365 1363257385
> > +
> > +\end_layout
> > +
> > +\begin_layout Plain Layout
> > +
> > +\change_inserted 1986246365 1363258610
> > +
> > +    u8 reserved[3];
> > +\end_layout
> > +
> > +\begin_layout Plain Layout
> > +
> > +\change_inserted 1986246365 1363259147
> > +
> > +    // buffer length for cmd field in requests.
> 
> size of the cmd field in VIRTIO_BLK_T_SCSI_CMD requests.
> 
> > + reset value 0.
> > +\end_layout
> > +
> > +\begin_layout Plain Layout
> > +
> > +\change_inserted 1986246365 1363257810
> > +
> > +    u32 cmd_size;
> 
> scsi_cmd_size
> 
> >  \change_unchanged
> >  
> >  \end_layout
> > @@ -6085,6 +6119,21 @@ Until version 1.1, QEMU remained in writeback mode even after a guest announced
> >  \end_inset
> >  
> >  .
> > +\change_inserted 1986246365 1363258989
> > +
> > +\end_layout
> > +
> > +\begin_layout Enumerate
> > +
> > +\change_inserted 1986246365 1363259237
> > +If VIRTIO_BLK_F_SCSI_CMD_SIZE is negotiated, Guest should set the desired
> > + size for scsi commands to the 
> 
> If both VIRTIO_BLK_F_SCSI and VIRTIO_BLK_F_SCSI_CMD_SIZE are negotiated,
> the driver should write a non-zero value to the scsi_cmd_size field
> before sending a VIRTIO_BLK_T_SCSI_CMD request.
> 
> > +\emph on
> > +cmd_size 
> > +\emph default
> > +field.
> > +\change_unchanged
> > +
> >  \end_layout
> >  
> >  \begin_layout Section*
> > @@ -6369,8 +6418,33 @@ cmd
> >  \emph default
> >   field is only present for scsi packet command requests, and indicates the
> >   command to perform.
> > - This field must reside in a single, separate read-only buffer; command
> > - length can be derived from the length of this buffer.
> > + 
> > +\change_inserted 1986246365 1363258881
> > +If VIRTIO_BLK_F_SCSI_CMD_SIZE feature bit is negotiated, Guest must set
> > + the command length by writing it to the cmd_size field in configuration
> > + space
> 
> If the VIRTIO_BLK_F_SCSI_CMD_SIZE feature bit is negotiated, the driver
> should write the length of the cmd field to the scsi_cmd_size field of
> the configuration space.
> 
> (please make sure bold and emphasis are consistent)
> 
> > +\begin_inset Foot
> > +status open
> > +
> > +\begin_layout Plain Layout
> > +
> > +\change_inserted 1986246365 1363258931
> > +Guest should always set cmd_size during initialization.
> 
> scsi_cmd_size
> 
> > +\change_unchanged
> > +
> > +\end_layout
> > +
> > +\end_inset
> > +
> > +.
> > + If VIRTIO_BLK_F_SCSI_CMD_SIZE is not negotiated, 
> > +\change_deleted 1986246365 1363258703
> > +T
> > +\change_inserted 1986246365 1363258703
> > +t
> > +\change_unchanged
> > +his field must reside in a single, separate read-only buffer; command length
> > + can be derived from the length of this buffer.
> 
> the command length...
> 
> >   
> >  \end_layout
> >  
> > 
> 
> Thanks,
> 
> Paolo
