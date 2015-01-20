From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 10/20] s390x/virtio-ccw: add virtio set-revision
	call
Date: Tue, 20 Jan 2015 11:08:24 +0000
Message-ID: <20150120110824.GJ17631@stefanha-thinkpad.redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5803948398617812596=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5803948398617812596==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline


--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 11, 2014 at 02:25:12PM +0100, Cornelia Huck wrote:
> @@ -608,6 +631,25 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              }
>          }
>          break;
> +    case CCW_CMD_SET_VIRTIO_REV:
> +        len = sizeof(revinfo);
> +        if (ccw.count < len || (check_len && ccw.count > len)) {
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!ccw.cda) {
> +            ret = -EFAULT;
> +            break;
> +        }
> +        cpu_physical_memory_read(ccw.cda, &revinfo, len);
> +        if (dev->revision >= 0 ||
> +            revinfo.revision > virtio_ccw_rev_max(dev)) {

In the next patch virtio_ccw_handle_set_vq() uses big-endian memory
access functions to load a struct from guest memory.

Here you just copy the struct in without byteswaps.

Are the byteswaps missing here?  (I guess this normally runs big-endian
guests on big-endian hosts so it's not noticable.)

Stefan

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUvjcoAAoJEJykq7OBq3PIjQEH/2wYU05/9J/YIGi2qq1+cMA8
whE0q/OaHMY6EUIBfPZwf7uHRtEgE4gN6feCrwvRlZufdEK2WgTIGxOD6sd9+iJi
qwGQV5wTJK7QGHwT/C+4x730B9yeLu41YbET49SBHB/U1mFaNEN8KVOzqAlRc9mW
pL2pNr7k1fO0zoMcxv3n7u3WI9ogsl1BLtpVFqBaQwYDocDYFk3gj08U2GRHqu8q
qUink9Ehsdg8+ae19OF3BQQ4YiRIyyj0AHeln5Bchu6mdvAzfXljknRHguaoR8O5
cIIINT5Mf4FJj42Sb9FxTeEaFwfR3/KVCnDB7YuYac46TtLW1W2v3W7qrqg1Qd4=
=YCQv
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--

--===============5803948398617812596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5803948398617812596==--
