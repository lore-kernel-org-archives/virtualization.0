From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 12/19] drm/bochs: Convert bochs driver to VRAM MM
Date: Mon, 6 May 2019 15:15:34 +0200
Message-ID: <78ce7242-81c0-e617-c181-5686aba3847b__7033.90647411055$1557148594$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506082649.942-13-tzimmermann@suse.de>
	<20190506124031.jwo5exbz6xk5fjan@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8252753547487546877=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506124031.jwo5exbz6xk5fjan@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8252753547487546877==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vXKLReJpdRKvT2Z7i8m4x6LWYEM8s1Ai6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vXKLReJpdRKvT2Z7i8m4x6LWYEM8s1Ai6
Content-Type: multipart/mixed; boundary="AB6gkshIrH37BwtImZ1wI4IS4ODICVRhY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: daniel@ffwll.ch, airlied@linux.ie, christian.koenig@amd.com,
 ray.huang@amd.com, hdegoede@redhat.com, noralf@tronnes.org,
 sam@ravnborg.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <78ce7242-81c0-e617-c181-5686aba3847b@suse.de>
Subject: Re: [PATCH v4 12/19] drm/bochs: Convert bochs driver to VRAM MM
References: <20190506082649.942-1-tzimmermann@suse.de>
 <20190506082649.942-13-tzimmermann@suse.de>
 <20190506124031.jwo5exbz6xk5fjan@sirius.home.kraxel.org>
In-Reply-To: <20190506124031.jwo5exbz6xk5fjan@sirius.home.kraxel.org>

--AB6gkshIrH37BwtImZ1wI4IS4ODICVRhY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 06.05.19 um 14:40 schrieb Gerd Hoffmann:
>   Hi,
>=20
>>  static const struct file_operations bochs_fops =3D {
>>  	.owner		=3D THIS_MODULE,
>> -	.open		=3D drm_open,
>> -	.release	=3D drm_release,
>> -	.unlocked_ioctl	=3D drm_ioctl,
>> -	.compat_ioctl	=3D drm_compat_ioctl,
>> -	.poll		=3D drm_poll,
>> -	.read		=3D drm_read,
>>  	.llseek		=3D no_llseek,
>> -	.mmap           =3D bochs_mmap,
>> +	DRM_VRAM_MM_FILE_OPERATIONS
>>  };
>=20
> What about llseek?  I think it should either be deleted (if not needed)=

> or added to DRM_VRAM_MM_FILE_OPERATIONS (if needed).

Some drivers set no_llseek, some leave the .llseek field to NULL. So I
don't set the field from DRM_VRAM_MM_FILE_OPERATIONS.

But now that you asked, I found that DRM actually requires no_llseek.
I'll add it to the default operations in the next iteration of the patch
set.

Best regards
Thomas

> cheers,
>   Gerd
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--AB6gkshIrH37BwtImZ1wI4IS4ODICVRhY--

--vXKLReJpdRKvT2Z7i8m4x6LWYEM8s1Ai6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlzQM3YACgkQaA3BHVML
eiNZsQgAh0PLjirbrnGoNT5rW/dvvnSfuenANfNjY/z/rUKQCDyLqudpFShQN7PC
rWBMVSG+nfwAu0XZpoI2JDmt3gRleeZ9krUs0Q6Ea5/cdBNohyv6QM9HP+8LQ7/h
NxJVcoAHTvSLpVvLBAw6QHzBLJm/px7zgyNNsnss6eagTZlk5tzh4hvpYaTAiO3W
f73Z3jPnXYJAH8ySjhef1IhAcKlh+lHTaontag+tq2RWTt5RaahLqoJgmHy2chGV
n7F7IWyMQHF+3U4Lu8eOD0yhSSFD+IXNUMME9xOfi3Q9WAlxkXXbJGqBkFpLqegC
RJjXv1PAzDQs0e8FoqAartEnq7Swlw==
=17sq
-----END PGP SIGNATURE-----

--vXKLReJpdRKvT2Z7i8m4x6LWYEM8s1Ai6--

--===============8252753547487546877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8252753547487546877==--
